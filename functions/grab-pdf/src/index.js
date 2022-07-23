const sdk = require("node-appwrite");
const PDFParser = require("pdf2json");

// /*
//   'req' variable has:
//     'headers' - object with request headers
//     'payload' - object with request body data
//     'env' - object with environment variables

//   'res' variable has:
//     'send(text, status)' - function to return text response. Status code defaults to 200
//     'json(obj, status)' - function to return JSON response. Status code defaults to 200

//   If an error is thrown, a response with code 500 will be returned.
// */

// module.exports = async function () {
//   const client = new sdk.Client();

//   // You can remove services you don't use
//   let account = new sdk.Account(client);
//   let avatars = new sdk.Avatars(client);
//   let database = new sdk.Databases(client, 'YOUR_DATABASE_ID');
//   let functions = new sdk.Functions(client);
//   let health = new sdk.Health(client);
//   let locale = new sdk.Locale(client);
//   let storage = new sdk.Storage(client);
//   let teams = new sdk.Teams(client);
//   let users = new sdk.Users(client);

  // if (
  //   !req.env['APPWRITE_FUNCTION_ENDPOINT'] ||
  //   !req.env['APPWRITE_FUNCTION_API_KEY']
  // ) {
  //   console.warn("Environment variables are not set. Function cannot use Appwrite SDK.");
  // } else {
  //   client
  //     .setEndpoint(req.env['APPWRITE_FUNCTION_ENDPOINT'])
  //     .setProject(req.env['APPWRITE_FUNCTION_PROJECT_ID'])
  //     .setKey(req.env['APPWRITE_FUNCTION_API_KEY'])
  //     .setSelfSigned(true);
  // }

//   client.setEndpoint = "http://localhost/v1"
//   client.setProject = "serah"

//   const response = storage.getFilePreview('62dbace7df70977ffb8a', '62dbad10f20caa2a85da');



// };


// module.exports();
// console.log("awd")


const client = new sdk.Client();

// You can remove services you don't use
let account = new sdk.Account(client);
let avatars = new sdk.Avatars(client);
let database = new sdk.Databases(client, 'YOUR_DATABASE_ID');
let functions = new sdk.Functions(client);
let health = new sdk.Health(client);
let locale = new sdk.Locale(client);
let storage = new sdk.Storage(client);
let teams = new sdk.Teams(client);
let users = new sdk.Users(client);

client.setEndpoint("http://localhost/v1").setProject("serah")

const promise = storage.getFileDownload('62dbace7df70977ffb8a', '62dbbaf64653f76ff738');
const pdfParser = new PDFParser();
const content = 'Some content!';
var beforeText = '';


pdfParser.on("pdfParser_dataReady", pdfData => {
  var i = 0;
  var isBeginningBalancePassed = false;

  var listOfObjects = [];
  for (var pageIndex in pdfData.Pages)
  {
    var page = pdfData.Pages[pageIndex]
    for (var textIndex in page.Texts)
    {
      var text = page.Texts[textIndex];
      var arr1 = text.R[0].TS;
      var arr2 = [0,11,0,0];

      if (arr1.length == arr2.length
        && arr1.every(function(u, i) {
            return u === arr2[i];
        })
      ) {
  
        var textData = text.R[0].T;
        textData = decodeURIComponent(textData);
 
          if (textData !== "")
           
     {            
            if (isDate(textData))
            {
              console.log("Date = " +textData)
            }
            else if (isMainTxn(beforeText))
            {
              console.log("Main Txn = " +textData)
            }
            else if (isAmount(textData))
            {
              console.log("Amount = " +textData);
            }
            else if (isBalance(textData))
            {
              console.log("Balance = " + textData)
            } 
            else if (isBeginningBalance(textData))
            {
              console.log("Beginning Balance = " + textData)
            }
            else if (isEndingBalance(textData))
            {
              console.log("Ending Balance = " + textData)
            }
            else if (isTotalCredit(textData))
            {
              console.log("Total Credit = " + textData)
            }
            else if (isTotalDebit(textData))
            {
              console.log("Total Debit = " + textData)
            }
            else
            {
              if (!isBlockKeyword(textData))
              {
                console.log("Recepient = " + textData)
              }         
            }
          }
          beforeText = textData;
        }
      } 
  }
}); 


function isDate(x)
{
  const re = /\d{2}\/\d{2}\/\d{2}/gm;
  return x.match(re);
}

function isMainTxn(x)
{
  if (isDate(beforeText))
  {
    return true;
  }
  return false;
}

function isAmount(x)
{
  if (x.slice(x.length - 1) == '+')
  {
    console.log("Credit")
    return true;
  }
  
  if (x.slice(x.length - 1) == '-')
  {
    console.log("Debit")
    return true;
  }

  return false;
}

function isBalance(x)
{
  if(isAmount(beforeText))
  {
    return true;
  }
  return false;
} 

function isBeginningBalance(x)
{
  if (beforeText == "BEGINNING BALANCE")
  {
    return true;
  }
  return false;
}



function isEndingBalance(x)
{
  if (beforeText == "ENDING BALANCE :")
  {
    return true;
  }
  return false;
}

function isTotalCredit(x)
{
  if (beforeText == "TOTAL CREDIT :")
  {
    return true;
  }
  return false;

}

function isTotalDebit(x)
{
  if (beforeText == "TOTAL DEBIT :")
  {
    return true;
  }
  return false;
}

function isBlockKeyword(x)
{
  if (x == "TOTAL DEBIT :" || x == "TOTAL CREDIT :" || x == "ENDING BALANCE :" ||
  x == "SAVINGS ACCOUNT" ||
  x == "BEGINNING BALANCE" ||
  x == 'PROTECTED BY PIDM UP TO RM250,000 FOR EACH DEPOSITOR')
  {
    return true;
  }
  return false;
}


promise.then(function (response) {  
  pdfParser.parseBuffer(response);

}, function (error) {
  console.log(error); // Failure
});
