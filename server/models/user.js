const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            //! regex (regular expression) - seq of charachter that specify a search pattern in a text
            validator: (value) => {
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: "Please enter a valid email address",
        },
    },
    password: {
        required: true,
        type: String,
        validate: {
            validator: (value) => {
                return value.length>6;
            },
            message: "Please enter a long password",
        },
    },
    address: {
        type:String,
        default: "",
    },
    type: {
        type: String,
        default: "user",
    },
    //todo Cart
});

const User = mongoose.model("User", userSchema);
module.exports = User;