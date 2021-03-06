### Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

[Virtual-Network-with-ELK-Stack-Deployment.png](https://github.com/horsley11/ELK-Stack-Configuration/blob/main/Diagrams/Virtual-Network-with-ELK-Stack-Deployment.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Ansible file may be used to install only certain pieces of it, such as Filebeat.

- [filebeat-config.yml](https://github.com/horsley11/ELK-Stack-Configuration/blob/main/ansible/filebeat-config.yml)

- [filebeat-playbook.yml](https://github.com/horsley11/ELK-Stack-Configuration/blob/main/ansible/roles/filebeat-playbook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the Damn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting high-traffic to the network.

Load balancers provide security to a network by equally distributing traffic across multiple servers, thus reducing chances for a single point of failure. By doing this, it eliminates the chances for a DDoS attack.

A jump box is an additional layer of security in which it has been configured to determine which devices are allowed acccess to a virtual network, and which are not. It is usually found between two firewalls and given extra protocols.
Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the network and system logs. To monitor the VMs, individual Beats are installed on each device. Two particular beats that is used will be: Filebeat and Metricbeat.

Filebeat gathers specific logs on each server that are fed into Logstash for later analysis. 

Metricbeat will monitor the demand that is placed on each web machine such as the CPU usage, and forward that information to Logstash for analysis.

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.4   | Linux            |
| Web-1    | Server   | 10.0.0.6   | Linux            |
| Web-2    | Server   | 10.0.0.5   | Linux            |
| Web-3    | Server   | 10.0.0.7   | Linux            |
| ELK      | Monitor  | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the jump box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:

Local Machine (Host) IP: 73.98.213.6

Machines within the network can only be accessed by the Jump Box Provisioner.


The machine that was given specific access to the ELK VM was the Jump Box Provisioner. The specific IP of the jump box provisioner is: 10.0.0.4 

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 73.98.213.6          |
| Web-1    | No                  | 10.0.0.4             |
| Web-2    | No                  | 10.0.0.4             |
| Web-3    | No                  | 10.0.0.4             |
| ELK      | No                  | 10.0.0.4             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it allows us to simply automate the manual process of updating and securing our webserver systems. Rather, a playbook is ran to do a variety of downloading, updating, expanding memory, and launching containers.

To properly install and implement a Docker container on your Virtual Machine, you will run the following playbook tasks:
- Install Docker
- Install Python3-pip
- Install Docker Python module
- Increase virtual memory for additional usage
- Download and launch docker elk container sebp/elk: 761

The following screenshot displays the result of running `docker ps -a` after successfully configuring the ELK instance.

[ELK Terminal.PNG](https://github.com/horsley11/ELK-Stack-Configuration/blob/main/Images/ELK%20Terminal.PNG)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

- Web-1 : 10.0.0.6
- Web-2 : 10.0.0.5
- Web-3 : 10.0.0.7

Installation of the following Beats on these machines are:

- Metricbeat
- Filebeat

These Beats allow you to collect the following information from each machine:

- Metricbeat will monitor the usage of computer processing power (CPU), memory (RAM), anything dealing with the workload of the machine. For example, if a server's CPU usage starts to approach a specific threshold limit, Metricbeat will relay that information to determine whether or not additional CPU power needs to be added to mitigate a potential source of failure.

- Filebeat gathers specific log data from each server on the network. Files that could be generated by Apache, Azure, MySQL databases, and any other source of log information are all sent to Logstash for further analysis.

### Using the Playbook

In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:

For Filebeat installation:
- Copy the filebeat-config.yml file to /etc/ansible.
- Update the filebeat-config.yml file to include the ELK-Machine's private IP address. Specifically update lines 1106 and 1806 with the ELK-Machine's IP address.
- Run the playbook, and navigate to http://[your-Elk-Machine-Public-IP-Address]:5601/app/kibana to check that the installation worked as expected.
- Attached is what Kibana will display for successful Filebeat installation with a different IP address of your ELK Machine
- [Filebeat Module Status.png](https://github.com/horsley11/ELK-Stack-Configuration/blob/main/Images/FileBeat%20Module%20status.PNG)

For Metricbeat installation:
- Copy the metricbeat-config.yml file to /etc/ansible.
- Update the metricbeat-config.yml file to include the ELK-Machine's private IP address. Specifically update lines 62 and 96 with the ELK-Machine's IP address.
- Run the playbook, and navigate to http://[your-Elk-Machine-Public-IP-Address]:5601/app/kibana to check that the installation worked as expected.
- Attached is what Kibana will display for successful Metricbeat installation with a different IP addres of your ELK Machine
- [Metricbeat Module Status.png](https://github.com/horsley11/ELK-Stack-Configuration/blob/main/Images/MetricBeat%20Module.PNG)

### Further implementation of the Playbooks

- To properly download two types of beats, the Metricbeat and Filebeat, two seperate playbooks will be ran to ensure proper installation of each individual beat on each server. In this file, I have attached the two playbooks which are named: filebeat-playbook.yml and metricbeat-playbook.yml. It can then be copied using the filepath of /etc/ansible/roles.

- After copying the playbook to the roles directory, we will want to update the host file located in the Ansible directory because it allows us to run the playbook on whichever specified machine that we choose. To properly ensure which machine will receive Filebeat and which will receive the ELK server, modification of the hosts file is needed. Around the bottom of the file, we will make sure to add in the IP addresses for the webservers that will have Filebeat installed on. An additional line will then be added specifically for just the ELK server with its private IP address.


- After modifcation of hosts file and running of the seperate playbooks, a user is now able to visit the Kibana graphical interface to filter through logs. To verify and visit the interface, simply type the following into your url browser: http://[ELK-Server-Public-IP-Address]:5601/app/kibana
