import React, { useEffect } from 'react';
import { Navigate } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { logout } from '../actions/auth.js';
import { isLoaded } from '../util/loadingObject'

const Logout = () => {
    const dispatch = useDispatch();
    const user = useSelector(state => state.auth);
    const isAuthenticated = isLoaded(user);

    // log out on render, and navigate to root on success
    useEffect(() => {
        dispatch(logout());
    }, []);

    if (isAuthenticated)
        return (<i>Logging you out ....</i>);
    else
        return (<Navigate to="/" />);
};

export default Logout;
