const AWS = require("aws-sdk");

const dynamo = new AWS.DynamoDB.DocumentClient();
const tableName = process.env.TMPLTZ_TABLENAME;

exports.handler = async (event, context) => {
  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json"
  };

  try {
    switch (event.routeKey) {
      case "DELETE /template/{template_id}":
        await dynamo
          .delete({
            TableName: tableName,
            Key: {
              user: context.authorizer.claims.emailID,
              id: event.pathParameters.template_id              
            }
          })
          .promise();
        body = `Deleted item ${event.pathParameters.template_id}`;
        break;
      case "GET /template/{template_id}":
        body = await dynamo
          .get({
            TableName: tableName,
            Key: {
              user: context.authorizer.claims.emailID,
              id: event.pathParameters.template_id
            }
          })
          .promise();
        break;
      case "GET /templates":
        body = await dynamo.scan({ 
            TableName: tableName,
            FilterExpression : 'user = :this_user',
            ExpressionAttributeValues : {':this_user' : context.authorizer.claims.emailID}
        }).promise();
        break;
      case "PUT /template":
        let requestJSON = JSON.parse(event.body);
        statusCode = 204;
        await dynamo
          .put({
            TableName: tableName,
            Item: {
              user: context.authorizer.claims.emailID,
              id: event.pathParameters.template_id,
              template: requestJSON.template,
              name: requestJSON.name,
              description: requestJSON.description
            }
          })
          .promise();
        body = `Put item ${requestJSON.id}`;

        break;
      default:
        throw new Error(`Unsupported route: "${event.routeKey}"`);
    }
  } catch (err) {
    statusCode = 400;
    body = err.message;
  } finally {
    body = JSON.stringify(body);
  }

  return {
    statusCode,
    body,
    headers
  };
};