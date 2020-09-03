<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Student</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
        <script>
        var jq = $.noConflict();         
        jq(document).ready(function(){	

			

			
            jq(document).on('click','.deleteRow', function(){
            	var currentRow = jq(this).closest('tr');
                var id = currentRow.find(".studentid").text();
                var name = currentRow.find(".studentname").text();
                var mail = currentRow.find(".studentmail").text();
                var department = currentRow.find(".studentdepartment").text();
                jq.get('delete',{id : id, name : name, mail : mail, department : department} ,function(result, status){
					if(result == 'success'){
						currentRow.remove();
					}
					else{
						jq("#message").empty();
						jq("#message").html('<p>Could not delete the row.</p>');
						
						}
                    });
            })	
			
        	jq.get('students',function(result, status){            	
        		jq.each(JSON.parse(result), function(i, student){
                	var info = ' ';
                	info += '<tr>';
                	info += '<th scope="row" class = "studentid">' + student.id + '</th>';
                	info += '<td class = "studentname">'+ student.name +'</td>';
                	info += '<td class = "studentmail">'+ student.mail +'</td>';
                	info += '<td class = "studentdepartment">'+ student.department +'</td>';
                	info += '<td><button class="btn btn-primary deleteRow">Delete</button></td>';
                	info += '<td><button class="btn btn-primary editRow">Edit</button></td>';
                	info += '</tr>';
             	jq("#students").prepend(info);
             	jq("#name").val("");
                jq("#mail").val("");
                jq("#department").val("");
        		});
             });

             
            jq(document).on('click','#save',function(){
                var name = jq("#name").val();
                var mail = jq("#mail").val();
                var department = jq("#department").val();
                jq.get('save',{name : name, mail : mail, department : department},function(result, status){
					if(result == "success"){
						jq.get('student',{mail : mail}, function(result, status){
							if(result != null ){
								var student = JSON.parse(result);
								var info = ' ';
		                    	info += '<tr>';
		                    	info += '<th scope="row" class = "studentid">' + student.id + '</th>';
		                    	info += '<td class = "studentname">'+ student.name +'</td>';
		                    	info += '<td class = "studentmail">'+ student.mail +'</td>';
		                    	info += '<td class = "studentdepartment">'+ student.department +'</td>';
		                    	info += '<td><button class="btn btn-primary deleteRow">Delete</button></td>';
		                    	info += '<td><button class="btn btn-primary editRow">Edit</button></td>';
		                    	info += '</tr>';
		                    	jq("#students").prepend(info);
		                    	jq("#message").empty();
							}else{
								jq("#message").empty();
								jq("#message").html('<p>Something went wrong. please try again.<p>');	
							}
							jq("#message").empty();	
						})
						jq("#name").val("");
	                    jq("#mail").val("");
	                    jq("#department").val("");
					}
					else{
						jq("#message").empty();
						jq("#message").html('<p>Something went wrong. please try again.<p>');
						jq("#name").val("");
	                    jq("#mail").val("");
	                    jq("#department").val("");
					}
                    });
                });

        			            
});
        </script>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row" style="margin-top: 30px;">
                <div class="col-sm-3">
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Name</label>
                        <input type="text" class="form-control" id="name" placeholder="Student name">
                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput2">Email</label>
                        <input type="email" class="form-control" id="mail" placeholder="Student email">
                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput2">Department</label>
                        <input type="text" class="form-control" id="department" placeholder="Department">
                    </div>
                    <button id = "save" class="btn btn-success">Save Student</button>
                    
                    <div id = "message" style="margin-top:9px">
                    	
                    </div>
                </div>
                <div class="col-sm-3">
                </div>
            </div>
            
            
            
            
            <div class="row" style="margin-top:15px;">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <table class="table table-dark">
                        <thead>
                          <tr>
                            <th scope="col">Id</th>
                            <th scope="col">Name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Department</th>
                            <th scope="col"></th>
                          </tr>
                        </thead>
                        <tbody id ="students">

                        </tbody>
                      </table>
                </div>
                <div class="col-sm-2">
                </div>
            </div>
            
            
            
        </div>



        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    </body>
</html>