require('dotenv').config();
//import from packages
const express = require("express");
const mongoose = require("mongoose");

//import from files
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");



//init
const app = express();
const PORT = process.env.PORT || 3000;
const DB = process.env.MONGO_URL;

//connect mongodb
mongoose.connect(DB)
    .then(() => {
        console.log("MonogoDB connected");
    })
    .catch((e) => {
        console.log(e);
    });

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`);
}); 