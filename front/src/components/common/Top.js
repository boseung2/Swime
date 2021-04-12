import React from 'react';
import StyledComponent from './StyledComponent';

const top = () => {
  return (
    <div>
      <StyledComponent />
      <span>swime</span>
      <button>모임만들기</button>
      <button>모임찾기</button>
      <li>
        <ul>회원가입</ul>
        <ul>로그인</ul>
      </li>
      <hr />
    </div>
  );
};

export default top;
