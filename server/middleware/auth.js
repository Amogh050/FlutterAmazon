const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
    try {
        const token = req.header('x-auth-token');
        //401-unauthorised
        if (!token) return res.status(401).json({ msg: 'No auth token,access denied' });

        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.status(401).json({ msg: 'Token verification failed, authorisation denied.' });

        req.user = verified.id;
        req.token = token;
        next();
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
}

module.exports = auth;