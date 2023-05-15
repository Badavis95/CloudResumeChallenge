<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
    <body onload="updateCounter()">
        <script>
        function updateCounter(){
        fetch('https://3kgi0zz7gj.execute-api.us-east-1.amazonaws.com/Prod',{
            method: 'GET'
        })
      .then(response => {
        if (
            // check if response's status is 200
            response.ok
        ) {
          return response.json()
        } else {
          throw new Error('something went wrong');
        }
      })
      .then(data => document.getElementById("Visit_Count").innerText = data.Visit_Count)
        }
        </script>
        Visits: <span id="Visit_Count"></span>
    </body>    
  </head>
</html>