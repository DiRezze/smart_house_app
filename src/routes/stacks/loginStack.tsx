import React from "react";
import { createStackNavigator } from "@react-navigation/stack";
import LoginTab from "../../(tabs)/loginTab";

const Stack = createStackNavigator();

const LoginStack = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="Login"
        component={LoginTab}
      />
    </Stack.Navigator>
  );
};

export default LoginStack;
