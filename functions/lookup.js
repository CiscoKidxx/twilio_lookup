const LookupsClient = require('twilio').LookupsClient;
const e164 = require('phone');

module.exports.handler = (event, context, callback) => {

  // pull number to lookup from api path parameter
  const rawTn = event.pathParameters.phoneNumber
  console.log(`rawTn = ${rawTn}`)

  // remove () and spaces from string and then convert to e164 format
  const scrubbedTn = e164(rawTn.replace(/(\(|\))/gmi, "").replace("%20", ""), "USA")[0]
  console.log(`scrubbedTn = ${scrubbedTn}`)

  // instantiate twilio client object with account details
  const client = require('twilio')(process.env.ACCOUNT_SID, process.env.AUTH_TOKEN);

  // create function that takes e164 number and returns promise of carrier name as a string
  const getCarrier = (number) => {

    return new Promise((resolve, reject) => {

      console.log(`GetCarrier: number = ${number}`)

      client.lookups.phoneNumbers(number)
        .fetch({
          type: 'carrier'
        })
        .then(phone_number => resolve(phone_number.carrier.name))
        .done();

    })
  }

  // execute function and send carrier name in http body
  getCarrier(scrubbedTn)
    .then((carrierName) => {

      console.log(`getCarrier execution: carrierName = ${carrierName}`);

      const response = {
        statusCode: 200,
        headers: {
          "Access-Control-Allow-Origin": "*" // Required for CORS support to work
        },
        body: JSON.stringify(carrierName)
      };

      console.log(`response = ${response}`);

      callback(null, response);
    })

}
