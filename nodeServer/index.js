const express = require("express");
const { ClarifaiStub, grpc } = require("clarifai-nodejs-grpc");

const app = express();

// Your PAT (Personal Access Token) can be found in the Account's Security section
const PAT = "e6d05a990a994ad6b3d3c4462831eac3";
// Specify the correct user_id/app_id pairings
// Since you're making inferences outside your app's scope
const USER_ID = "clarifai";
const APP_ID = "main";
// Change these to whatever model and image URL you want to use
const MODEL_ID = "apparel-detection";
const MODEL_VERSION_ID = "1ed35c3d176f45d69d2aa7971e6ab9fe";
const IMAGE_URL = "https://samples.clarifai.com/metro-north.jpg";

const stub = ClarifaiStub.grpc();

// This will be used by every Clarifai endpoint call
const metadata = new grpc.Metadata();
metadata.set("authorization", "Key " + PAT);

const detect = (imageDetect) => {
  return new Promise((resolve, reject) => {
    stub.PostModelOutputs(
      {
        user_app_id: {
          user_id: USER_ID,
          app_id: APP_ID,
        },
        model_id: MODEL_ID,
        version_id: MODEL_VERSION_ID, // This is optional. Defaults to the latest model version
        inputs: [
          {
            data: {
              image: {
                url: imageDetect,
                allow_duplicate_url: true,
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
          reject(new Error("Post model outputs failed, status: " + response.status.description));
          return;
        }

        const regions = response.outputs[0].data.regions;
        const results = [];
        regions.forEach((region) => {
          // Accessing and rounding the bounding box values
          const boundingBox = region.region_info.bounding_box;
          const topRow = boundingBox.top_row.toFixed(3);
          const leftCol = boundingBox.left_col.toFixed(3);
          const bottomRow = boundingBox.bottom_row.toFixed(3);
          const rightCol = boundingBox.right_col.toFixed(3);

          region.data.concepts.forEach((concept) => {
            // Accessing and rounding the concept value
            const name = concept.name;
            const value = concept.value.toFixed(4);

            results.push({
              name,
              value,
              boundingBox: {
                topRow,
                leftCol,
                bottomRow,
                rightCol,
              },
            });
          });
        });
        resolve(results);
      }
    );
  });
};

app.get("/detect", async (req, res) => {
  try {
    const image =
      "https://images.bewakoof.com/uploads/grid/app/casual-outfits-for-men-bewakoof-blog-16-1615892384.jpg";

    const results = await detect(image);
    
    // Do something with the results here
    console.log(results);

    // Send a response to the client
    res.send(results);
  } catch (error) {
    console.error("Error:", error.message);
    res.status(500).send("Internal Server Error");
  }
});

app.listen(8001, () => {
  console.log("Server is running on port 8001");
});
