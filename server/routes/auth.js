const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");

const authRouter = express.Router();

// signup route
authRouter.post("/api/signup", async (req, res) => {
    try {
        //get data from client
        const { name, email, password } = req.body;

        //weak paddword - 6 char - same acc with email
        //post data in database
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: 'User with same email already exsist!!' });
        }

        const hashedPassword = await bcryptjs.hash(password,8);

        let user = new User({
            name,
            email,
            password: hashedPassword,
        });
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

    //return data to the user
});

//signin route


module.exports = authRouter;