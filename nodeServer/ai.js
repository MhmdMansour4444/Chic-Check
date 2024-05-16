const express = require("express");
const { ClarifaiStub, grpc } = require("clarifai-nodejs-grpc");

const app = express();
app.use(express.json()); // To parse JSON bodies

// Your PAT (Personal Access Token) can be found in the Account's Security section
const PAT = "e6d05a990a994ad6b3d3c4462831eac3";
// Specify the correct user_id/app_id pairings
// Since you're making inferences outside your app's scope
const USER_ID = "openai";
const APP_ID = "chat-completion";
// Change these to whatever model and text you want to use
const MODEL_ID = "gpt-4o";
const MODEL_VERSION_ID = "c82eaa1d693542708db1b5171fb3429b";
const RAW_TEXT = "I love your product very much";
// To use a hosted text file, assign the url variable
// const TEXT_URL = 'https://samples.clarifai.com/negative_sentence_12.txt';
// Or, to use a local text file, assign the url variable
// const TEXT_FILE_LOCATION = 'YOUR_TEXT_FILE_LOCATION_HERE';

const stub = ClarifaiStub.grpc();

// This will be used by every Clarifai endpoint call
const metadata = new grpc.Metadata();
metadata.set("authorization", "Key " + PAT);

const processImageAndText = (imageURL, rawText) => {
  return new Promise((resolve, reject) => {
    stub.PostModelOutputs(
      {
        user_app_id: {
          user_id: USER_ID,
          app_id: APP_ID,
        },
        model_id: MODEL_ID,
        version_id: MODEL_VERSION_ID,
        inputs: [
          {
            data: {
              image: {
                url: imageURL,
              },
              text: {
                raw: rawText,
              },
            },
          },
        ],
      },
      metadata,
      (err, response) => {
        if (err) {
          reject(err);
          return;
        }

        if (response.status.code !== 10000) {
          reject(
            new Error(
              "Post model outputs failed, status: " +
                response.status.description
            )
          );
          return;
        }
        const output = response.outputs[0];

        // Extracting only the raw text from the response
        const rawResponse = output.data.text.raw;

        resolve(rawResponse);
      }
    );
  });
};

app.post("/process", async (req, res) => {
  try {
    const { imageURL, rawText } = req.body;

    if (!imageURL || !rawText) {
      return res
        .status(400)
        .send("Bad Request: 'imageURL' and 'rawText' are required");
    }

    const rawResponse = await processImageAndText(imageURL, rawText);

    res.send({ rawText: rawResponse }); // Sending only the raw text as response
  } catch (error) {
    console.error("Error:", error.message);
    res.status(500).send("Internal Server Error");
  }
});

app.listen(8001, () => {
  console.log("Server is running on port 8001");
});
