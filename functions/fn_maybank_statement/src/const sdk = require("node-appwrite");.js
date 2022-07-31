const sdk = require("node-appwrite");
const PDFParser = require("pdf2json");
const moment = require("moment");

module.exports = async function (req, res) {

    const client = new sdk.Client();
    const storage = new sdk.Storage(client);
    const pdfParser = new PDFParser();
    var beforeText = '';

    if (
        !req.env['APPWRITE_FUNCTION_ENDPOINT'] ||
        !req.env['APPWRITE_FUNCTION_API_KEY']
    ) {
        console.warn("Environment variables are not set. Function ct use Appwrite SDK.");
    } else {
        client
            .setEndpoint(req.env['APPWRITE_FUNCTION_ENDPOINT'])
            .setProject(req.env['APPWRITE_FUNCTION_PROJECT_ID'])
            .setKey(req.env['APPWRITE_FUNCTION_API_KEY'])
            .setSelfSigned(true);
    }

    const promise = storage.getFileDownload("st_maybank",
        "statetement-01");

    promise.then(function (response) {
        pdfParser.parseBuffer(response);

    }, function (error) {
        console.log(error); // Failure
    });

    pdfParser.on("pdfParser_dataReady", pdfData => {
        var object = {};
        for (var pageIndex in pdfData.Pages) {
            var page = pdfData.Pages[pageIndex]
            for (var textIndex in page.Texts) {
                var text = page.Texts[textIndex];
                var arr1 = text.R[0].TS;
                var arr2 = [0, 11, 0, 0];

                if (arr1.length == arr2.length
                    && arr1.every(function (u, i) {
                        return u === arr2[i];
                    })
                ) {

                    var textData = text.R[0].T;
                    textData = decodeURIComponent(textData);

                    if (textData !== "") {
                        if (isDate(textData)) {
                            if (object != {}) {
                                res.json({
                                    data: object
                                })
                                // const promise = database.createDocument('62dc1fac60cfa3a75af8', 'unique()', {
                                //     name: object.name,
                                //     desc: object.desc,
                                //     date: object.date,
                                //     balance: object.balance,
                                //     amount: object.amount
                                // });

                                // promise.then(function (response) {
                                //     console.log(response); // Success
                                // }, function (error) {
                                //     console.log(error); // Failure
                                // });
                            }
                            console.log("Date = " + textData)
                            object = {};
                            object.date = moment(textData, "DD/MM/YY").unix()

                        }
                        else if (isMainTxn(beforeText)) {
                            console.log("Main Txn = " + textData)
                            object.name = textData;
                        }
                        else if (isAmount(textData)) {
                            console.log("Amount = " + textData);
                            let symbol = textData.slice(textData.length - 1);

                            object.amount = parseFloat(textData.replace('+', '').replace('-', '').replace(',', ''))

                            if (symbol == '-') {
                                object.amount *= -1;
                            }

                        }
                        else if (isBalance(textData)) {
                            console.log("Balance = " + textData)
                            object.balance = parseFloat(textData.replace(",", ""));
                        }
                        else if (isBeginningBalance(textData)) {
                            console.log("Beginning Balance = " + textData)
                        }
                        else if (isEndingBalance(textData)) {
                            console.log("Ending Balance = " + textData)
                        }
                        else if (isTotalCredit(textData)) {
                            console.log("Total Credit = " + textData)
                        }
                        else if (isTotalDebit(textData)) {
                            console.log("Total Debit = " + textData)
                        }
                        else {
                            if (!isBlockKeyword(textData)) {
                                console.log("Recepient = " + textData)
                                textData = textData.trim().replace(/\s\s+/g, ' ');
                                if (!object.desc) {
                                    object.desc = textData
                                }
                                else {
                                    object.desc += ' ' + textData
                                }
                            }
                        }
                    }
                    beforeText = textData;
                }
            }
        }
    });



    function isDate(x) {
        const re = /\d{2}\/\d{2}\/\d{2}/gm;
        return x.match(re);
    }

    function isMainTxn(x) {
        if (isDate(beforeText)) {
            return true;
        }
        return false;
    }

    function isAmount(x) {
        if (x.slice(x.length - 1) == '+') {
            console.log("Credit")
            return true;
        }

        if (x.slice(x.length - 1) == '-') {
            console.log("Debit")
            return true;
        }

        return false;
    }

    function isBalance(x) {
        if (isAmount(beforeText)) {
            return true;
        }
        return false;
    }

    function isBeginningBalance(x) {
        if (beforeText == "BEGINNING BALANCE") {
            return true;
        }
        return false;
    }



    function isEndingBalance(x) {
        if (beforeText == "ENDING BALANCE :") {
            return true;
        }
        return false;
    }

    function isTotalCredit(x) {
        if (beforeText == "TOTAL CREDIT :") {
            return true;
        }
        return false;

    }

    function isTotalDebit(x) {
        if (beforeText == "TOTAL DEBIT :") {
            return true;
        }
        return false;
    }

    function isBlockKeyword(x) {
        if (x == "TOTAL DEBIT :" || x == "TOTAL CREDIT :" || x == "ENDING BALANCE :" ||
            x == "SAVINGS ACCOUNT" ||
            x == "BEGINNING BALANCE" ||
            x == 'PROTECTED BY PIDM UP TO RM250,000 FOR EACH DEPOSITOR') {
            return true;
        }
        return false;
    }
};

