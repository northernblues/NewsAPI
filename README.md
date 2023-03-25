# newsapiv1

A new Flutter project.

The remote server API being fetched is from -
https://newsapi.org/v2/everything?q=nepal&from=2023-02-26&sortBy=publishedAt&apiKey=42037dd664e945e0bdea7e9035dfbe9e

Keep note : that it throws error if you provide an incorrect or past date to an API that expects a current or future date, the API may respond with an error message indicating that the date is invalid or out of range. The specific error message may vary depending on the API service you are using.

In that case, change the date in api to match the date it provides services.
