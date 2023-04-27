<html>
<body>
<script>
    const apiendpoint = 'https://3kgi0zz7gj.execute-api.us-east-1.amazonaws.com/DB-Updater/counter';
    fetch('apiendpoint') 
        .then(response =>{
        console.log(response);
        return response.blob();
        })
</script>
</body>
</html>