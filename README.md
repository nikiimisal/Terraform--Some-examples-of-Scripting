>Quick flow 

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

_ _ _

<h2>Life Cycle rule (Block) </h2>

Lifecycle rules control how Terraform creates, updates, or deletes a resource.<br>
Lifecycle helps you protect, recreate, or manage a resource’s behavior during Terraform operations.

Example uses:

➢ prevent_destroy → stop a resource from being accidentally deleted<br>
➢ create_before_destroy → create a new one first, then delete the old one<br>
➢ ignore_changes → ignore specific attribute changes<br>

```
lifecycle {
  prevent_destroy      = true
  create_before_destroy = true
  ignore_changes        = [
    tags,
  ]
}
```


<h1>Statefile</h1>

>A Terraform state file is a file that stores the current status of all infrastructure created or managed by Terraform.

Terraform Backend is the place where the Terraform state file is stored and managed (local, S3, etc.).

i.  local backend<br>
    Local backend stores the Terraform state file on your local machine (your laptop or system).
    
ii. Remote backend <br>
    Remote backend stores the Terraform state file on remote storage like S3, Terraform Cloud, or any shared location for team use.
<br>
<br>

● Using source-code tools like GitHub can create issues such as ,<br>
  -- file corruption<br>
  -- lack of collaboration<br>
  -- data loss<br>
  -- inconsistency.

● To solve these problems, Terraform provides a feature called `Terraform Backend`.<br>
● Backends offer a feature called `state locking`, this functionality avalible on `local backend`.<br>
● Because of this, we should never store Terraform state files in source-code managnment such as GitHub or GitLab.<br>
● Instead, we store `state files` on platforms that support `remote backends`.<br>
● `Remote backends` are platforms that can store and manage Terraform state files remotely.<br>
● Examples of remote backends include Amazon S3, Terraform Cloud, and HashiCorp Consul.<br>

>Now we will look at an example using the S3 platform, and we will also see how conflicts occur in both the `local backend` and the `remote backend`.

Ex.   So how does `state locking` work in the `local backend` ..!<br>
      I can share some screenshots—when you run terraform apply at the same time, it will give an error.

      
| **VS Code**    | **Terminal**          |
|--------------------------------|------------------------------------|
| ![VS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/s/Screenshot%202025-11-25%20092333.png?raw=true) | ![AWS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/s/Screenshot%202025-11-25%20092036.png?raw=true) |

<br>
<br>

Ex.  Now we will look at an example of a `remote backend` using S3.

   1. Create a S3 bucket [click here](https://github.com/nikiimisal/S3-CLI-IAm)
   2. For that, we need to add a backend block in our Terraform code.
   3. Now we need to run `terraform init` because S3 is a new service. Earlier, when we ran Terraform init, it only read the instance configuration. So now we must run the Terraform command again and then              run command `terraform apply`.
   4. Now you can delete the state file from your local machine. This is just removal, not a destroy operation.
      ```
      rm -rf terraform.tfstate  
       rm -rf terraform.tfstate.backup
      ```
   5. Here’s the catch: you don’t need to manually keep a backup of the state file because the S3 bucket supports versioning.
   6. Just go to the S3 bucket page → click your bucket name → Properties → enable Versioning.

| **Bucket**    | **Terminal init**          | **Bucket Object**          | **Stored code in object**          |
|--------------------------------|------------------------------------|------------------------------------|------------------------------------|
| ![VS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/s/Screenshot%202025-11-25%20093344.png?raw=true) | ![AWS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/s/Screenshot%202025-11-25%20094415.png?raw=true) | ![AWS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/s/Screenshot%202025-11-25%20155703.png?raw=true) | ![AWS](https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/s/Screenshot%202025-11-25%20094630.png?raw=true) |

      
<h2>Backend block</h2>

  >A backend block in Terraform is a special configuration block that tells Terraform where to store and manage the state file.

Short & Simple Definition:<br>
  --> The backend block is used to configure where Terraform should store the state file — locally or in a remote service like S3. 

  Above, we discussed how the backend block is used. Here, I’m only explaining what a backend block is.

   <p align="center">
  <img src="https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/s/Screenshot%202025-11-25%20154814.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>

<h2>Some command's</h2>

>Terraform state commands

The points we covered earlier were related to the `state file`, so you can use those state-related commands in this example. Or I can demonstrate here how these commands work.

<h4>Terraform State Pull</h4>

The `terraform state` command is used to view, inspect, modify, or manage the Terraform state file without changing real infrastructure.

```
terraform state pull
```

   <p align="center">
  <img src="https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/s/Screenshot%202025-11-25%20155055.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>

<h4>Terraform State List</h4>

➜ It’s hard to check how many resources were created after running `Terraform state pull` command, so we use `terraform state list` to easily see all resources.<br>
➜ This command shows all the resources that are currently stored in the Terraform state file.

```
terraform state list
```
   <p align="center">
  <img src="https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/s/Screenshot%202025-11-25%20155155.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>

<h4>Terraform State Show</h4>

➜ If I want detailed information about a particular resource, I can use the `terraform state show` command.<br>
➜ The `terraform state show` command is used to display detailed information about a specific resource stored in the Terraform state file.

```
terraform state show <resource_address(Name)>
```


   <p align="center">
  <img src="https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/s/Screenshot%202025-11-25%20155332.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>

<h4>Terraform State MV</h4>

The `terraform state` mv command is used to move or rename a resource inside the Terraform state file without recreating it.

➜ Renames resources without recreating them<br>
➜ Prevents downtime<br>
➜ Keeps the state file clean and organized<br>
➜ Helps fix wrong resource names or paths<br>
➜ Useful during refactoring of Terraform code

```
terraform state mv <aws_instance.logical-instance-name> <aws_instance.new-resource-instance-name>
```
   <p align="center">
  <img src="https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/s/Screenshot%202025-11-25%20155632.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>

<h4>Terraform State RM</h4>

➜ `terraform state rm` is used to remove a resource from the Terraform state file without deleting it from the real infrastructure.<br>
➜ Just like we use `terraform import` to bring an external resource (e.g., an EC2 instance) into Terraform, <br>
➜ we can use `terraform state rm` to remove a resource from Terraform’s state without deleting it from AWS.

>if you want to manage the resource manually (also you need to remove block in `main.tf` file manually).

```
terraform state rm <aws_instance.terraform-logical-name-of-ec2>
```

   <p align="center">
  <img src="https://github.com/nikiimisal/Terraform--Some-examples-of-Scripting/blob/main/img/s/Screenshot%202025-11-25%20155856.png?raw=true" width="500" alt="Initialize Repository Screenshot">
</p>


_ _ _
<h1>Terraform Provisioner</h1>

In Terraform, a provisioner is a component that executes scripts or commands on a local or remote machine during the creation or destruction of a resource. Provisioners are used when something cannot be handled by Terraform’s declarative model — such as installing software, bootstrapping a new server, copying files, or performing cleanup tasks before destroying a resource.

Simple Explanation:
Think of Terraform as a tool that builds the house (the infrastructure).<br>
A provisioner is like the set of instructions you give to arrange the furniture inside the house or clean the house after the work is done.

Declarative vs Imperative:
Terraform is mainly declarative — you describe what you want. Provisioners introduce imperative steps — you specify step-by-step instructions to configure something.

>Last Resort Tool:<br>
HashiCorp recommends using provisioners only as a last resort. Preferred alternatives are user_data (cloud-init) or custom machine images with tools like Packer, because they provide better reliability and idempotency.

Important Point :
user_data or cloud-init scripting works only on cloud platforms like AWS, Azure, or GCP because these clouds support metadata services.
But Terraform provisioners can run anywhere:
• On your local machine
• On AWS
• On Azure
• On GCP
• On on-prem servers
• On any VM that supports SSH or WinRM
This gives provisioners more flexibility, especially in environments where cloud-init is not available.

Why Should We Use Provisioners:
• When cloud-init/user_data cannot do the job
• When you need to configure something after the server is created
• When you want to copy files inside a machine
• When you need to run one-time setup commands
• When you want to trigger local scripts like Ansible, Bash, or Python after terraform apply
• When working in environments where metadata/user_data is not supported

Advantages of Terraform Provisioners:
• Very easy to write and understand.
• Works in all environments (local, AWS, Azure, GCP, on-prem).
• Good for quick setup tasks like installing packages or running small scripts.
• Helpful when cloud-init or user_data is not supported.
• Can trigger external tools like Ansible, Python, Bash, etc.
• Useful for copying files or doing one-time configuration steps.

Disadvantages of Terraform Provisioners:
• Not very reliable — SSH/WinRM failure can break terraform apply.
• Breaks Terraform’s declarative nature by adding imperative logic.
• Not idempotent — commands may run again and cause issues on repeated apply.
• Hard to debug — script errors inside the machine fail the whole plan.
• Officially discouraged by HashiCorp.
• Makes Terraform configuration more complex and harder to maintain.


<h3>Main Types of Provisioners</h3>
<h5>There are three primary types of built-in provisioners: </h5>

| **Provisioner Type** | **Execution Location**                                      | **Primary Use Case**                                                                                                           |
| -------------------- | ----------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| local-exec           | On the machine running terraform apply                      | Running local scripts, triggering external tools like Ansible, or saving outputs to a local file.                              |
| remote-exec          | On the remote resource (e.g., a newly created EC2 instance) | Running commands or scripts on the resource itself, like installing packages (Nginx, Apache) via SSH or WinRM.                 |
| file                 | From the local machine to the remote resource               | Copying files or directories (e.g., configuration files, certificates, or application binaries) to the newly created resource. |






