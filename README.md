<h2>User Data Script</h2>

● Earlier, we used a user-data script in AWS. Let’s focus on that again for a moment—just a reminder of the process.<br>
● We can deploy an application even without using the terminal by using this.<br>
● Giving commands at the time of launching an EC2 instance is called a user-data script.


| **aws console**    | **output**          |
|--------------------------------|------------------------------------|
| ![VS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/Screenshot_20251123-170329.png?raw=true) | ![AWS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/Screenshot_20251123-170400.png?raw=true) |



● Now, just like we pass a user-data script here, we also pass the user-data script through Terraform here .


 <p align="center">
  <img src="https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/Screenshot%202025-11-23%20173126.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>



<h2>Output Block</h2>
● What does the output block do?<br>
--> For example, if your EC2 instance is launch(running), it shows its IP in print. If an LB is launched, it prints the LB endpoint.


| **O/P block**    | **variable-O/P block(prefer)**          | **In Terminal**          |
|--------------------------------|------------------------------------|------------------------------------|
| ![VS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/Screenshot%202025-11-23%20172907.png?raw=true) | ![AWS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/Screenshot%202025-11-23%20180323.png?raw=true) | ![AWS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/Screenshot%202025-11-23%201731261.png?raw=true) |



<h2>Data Block</h2>

● Whatever you write inside a `resource block`, Terraform creates.<br>
● Whatever you write inside a `data block`, Terraform sends to the AWS console and reads from there.<br>

<br>
Why we need to use Data Block ?<br>
-->  To read the data or resources are created outside the terraform..

 <p align="center">
  <img src="https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/Screenshot%202025-11-23%20183916.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>




<h2>Terraform Import</h2>

When importing an instance into Terraform, all its values must match the actual server.<br>

I’m using `hardcoding` here only for demonstration; prefer `dynamic assignment`.

| **Terraform Import(VS)**    | **Terminal**          |
|--------------------------------|------------------------------------|
| ![VS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/Screenshot%202025-11-23%20192331.png?raw=true) | ![AWS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/Screenshot_20251123-190336.png?raw=true) |

