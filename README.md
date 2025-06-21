# 🗣️ AWS Text-to-Speech App with Amazon Polly

This is a serverless web application that converts user text input into spoken audio using AWS Polly. The application was built for educational purposes and showcases integration between several AWS services through Terraform.

## Infrastructure:
<img width="1000" alt="image" src="https://github.com/user-attachments/assets/b3d1900c-1ad7-4314-b747-c14fad7bd8c4" />

---

## 🚀 Features

- Text-to-speech conversion using **Amazon Polly**
- Audio files stored in **Amazon S3** with public access
- Record status and metadata managed in **DynamoDB**
- **SNS** triggers **Lambda** functions to handle audio generation
- RESTful backend with **API Gateway**
- Frontend hosted as a static website in **S3**
- Fully automated infrastructure using **Terraform**

---

## 🛠️ Technologies

- **AWS Services:** S3, Lambda, API Gateway, SNS, DynamoDB, Polly, IAM
- **Infrastructure as Code:** Terraform
- **Frontend:** HTML, CSS, JavaScript, jQuery
- **Backend:** Python (AWS Lambda)

---

## 📁 Project Structure

```
aws-text-to-speech/
├── lambda_functions/
│   ├── get_post.py          # Lambda to retrieve data from DynamoDB
│   └── new_post.py          # Lambda to insert a new post and publish to SNS
├── static-site/
│   ├── index.html
│   ├── styles.css
│   └── scripts.js
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── ...
└── README.md
```

---

## 🧪 How it Works

1. **User submits text** → triggers `/new_post` endpoint via API Gateway.
2. **Lambda stores post** in DynamoDB with a `PROCESSING` status and sends the post ID to SNS.
3. **Another Lambda is triggered via SNS** → calls Polly to synthesize the text, stores the `.mp3` file in S3, and updates the DynamoDB item with the public S3 URL and status `UPDATED`.
4. **User queries by post ID** → frontend fetches status (any dev, could push an issue to upgrade js).

---

## 🧠 Notes

- The `.mp3` files must be set as `public-read` in S3.
- URLs are generated dynamically based on region and stored in DynamoDB.
- Designed and tested in the **N. Virginia** region (`us-east-1`).

---

## 📸 Demo

Include a screenshot of the web UI or a terminal session showing Polly's voice synthesis.

---

## 🙌 Author

Built by Mateo as part of a DevOps & Cloud learning journey. Cloud | DevOps | AWS | Terraform | Automation
