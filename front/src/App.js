import React from 'react';
import { Route } from 'react-router-dom';
import GroupListPage from './pages/GroupListPage';
import GroupRegisterPage from './pages/GroupRegisterPage';
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';
import Top from './components/common/Top';

const App = () => {
  return (
    <>
      <Top></Top>
      <Route component={GroupListPage} path="/" exact={true} />
      <Route component={GroupRegisterPage} path="/group/register" />
      <Route component={LoginPage} path="/login" />
      <Route component={RegisterPage} path="/register" />
    </>
  );
};

export default App;
