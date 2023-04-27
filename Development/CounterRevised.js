// Set the endpoint URL for your API Gateway and the path to your Lambda function
const apiEndpointUrl = 'https://3kgi0zz7gj.execute-api.us-east-1.amazonaws.com/DB-Updater'
const lambdaFunctionPath = '/';

// Retrieve the current visitor count from your API Gateway
let visitorCount = 0;

fetch(apiEndpointUrl)
  .then(response => response.json())
  .then(data => visitorCount = data.visitorCount)
  .catch(error => console.log('Error retrieving visitor count:', error));

// Update the visitor count by invoking your Lambda function via API Gateway
function updateVisitorCount() {
  fetch(apiEndpointUrl, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      visitorCount: visitorCount
    })
  })
    .then(response => response.json())
    .then(data => {
      visitorCount = data.visitorCount;
      displayVisitorCount();
    })
    .catch(error => console.log('Error updating visitor count:', error));
}

// Display the current visitor count on your webpage
function displayVisitorCount() {
  const visitorCountElement = document.getElementById('visitor-count');
  visitorCountElement.innerHTML = visitorCount;
}

// Call the updateVisitorCount function whenever your webpage is loaded or refreshed
updateVisitorCount();

// Call the updateVisitorCount function whenever your webpage is unloaded or closed
window.addEventListener('beforeunload', () => {
  fetch(apiEndpointUrl, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      visitorCount: visitorCount
    })
  })
    .catch(error => console.log('Error updating visitor count:', error));
});
