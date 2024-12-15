<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>

        <!-- Materialize CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

        <!-- Materialize JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col m6 offset-m3">
                    <div class="card">
                        <div class="card-content">
                            <h3>Register Here!</h3>
                            <h5 id="msg" class="center-align"></h5>

                            <div class="form center-align">
                                <!-- Registration Form -->
                                <form action="Register" method="post" id="myform">
                                    <input type="text" name="user_name" placeholder="Enter user name" required />
                                    <input type="password" name="user_password" placeholder="Enter user password" required />
                                    <input type="email" name="user_email" placeholder="Enter user email" required />
                                    
                                    <!-- Submit Button -->
                                    <button type="submit" class="btn">Submit</button>
                                </form>
                            </div>

                            <!-- Loader -->
                            <div class="loader center-align" style="margin-top: 10px; display: none">
                                <div class="preloader-wrapper big active">
                                    <div class="spinner-layer spinner-blue">
                                        <div class="circle-clipper left"><div class="circle"></div></div>
                                        <div class="gap-patch"><div class="circle"></div></div>
                                        <div class="circle-clipper right"><div class="circle"></div></div>
                                    </div>
                                </div>
                                <h5>Please wait...</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- JQuery -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" 
                integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" 
                crossorigin="anonymous"></script>

        <script>
            $(document).ready(function () {
                console.log("Page is ready...");

                // Handle form submission
                $("#myform").on('submit', function (event) {
                    event.preventDefault(); // Prevent default form submission
                    
                    // Prepare form data
                    let formData = {
                        user_name: $("input[name='user_name']").val(),
                        user_password: $("input[name='user_password']").val(),
                        user_email: $("input[name='user_email']").val(),
                    };

                    // Show loader and hide form
                    $(".loader").show();
                    $(".form").hide();

                    // AJAX request
                    $.ajax({
                        url: "Register", 
                        data: formData, 
                        type: 'POST',
                        dataType: 'text', // Expecting plain text response
                        success: function (data) {
                            console.log("Success Response:", data);
                            $(".loader").hide();
                            $(".form").show();

                            // Check response
                            if (data.trim() === 'done') {
                                $('#msg').text("Successfully Registered!").addClass('green-text');
                            } else {
                                $('#msg').text(data.trim()).addClass('red-text');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.error("Error Response:", textStatus, errorThrown);
                            $(".loader").hide();
                            $(".form").show();
                            $('#msg').text("An error occurred. Please try again.").addClass('red-text');
                        }
                    });
                });
            });
        </script>
    </body>
</html>
