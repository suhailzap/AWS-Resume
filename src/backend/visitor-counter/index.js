const AWS = require('aws-sdk');
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
    const tableName = process.env.TABLE_NAME;
    const counterId = 'visitor-count';

    try {
        // Get current count
        const getParams = {
            TableName: tableName,
            Key: { id: counterId }
        };

        const result = await dynamoDB.get(getParams).promise();
        let count = (result.Item && result.Item.count) || 0;

        // Increment count
        count += 1;

        // Update count in DynamoDB
        const updateParams = {
            TableName: tableName,
            Key: { id: counterId },
            UpdateExpression: 'SET #count = :count',
            ExpressionAttributeNames: {
                '#count': 'count'
            },
            ExpressionAttributeValues: {
                ':count': count
            }
        };

        await dynamoDB.update(updateParams).promise();

        // Return response
        return {
            statusCode: 200,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'POST,OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type'
            },
            body: JSON.stringify({ count })
        };
    } catch (error) {
        console.error('Error:', error);
        return {
            statusCode: 500,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'POST,OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type'
            },
            body: JSON.stringify({ error: 'Internal server error' })
        };
    }
}; 