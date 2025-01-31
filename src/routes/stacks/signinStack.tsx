import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import SigninTab from '../../(tabs)/signinTab';

const Stack = createStackNavigator();

const SigninStack = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen name="Signin" component={SigninTab} />
    </Stack.Navigator>
  );
};

export default SigninStack;
