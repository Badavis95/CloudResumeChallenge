const apiEndpointUrl = 'https://3kgi0zz7gj.execute-api.us-east-1.amazonaws.com/DB-Updater/counter';
   
// Retrieve the current visitor count from your API Gateway
fetch(apiEndpointUrl)
  .then(response => response.json())
  .then(data => {
    console.log(data); // log the response from the API Gateway
    const visitorCountElement = document.getElementById('visitorCount');
    visitorCountElement.innerHTML = data.visitorCount;
  })
  .catch(error => console.log('Error retrieving visitor count:', error));