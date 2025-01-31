import React from "react";
import {
  createStackNavigator,
  TransitionPresets,
} from "@react-navigation/stack";
import configTab from "../../(tabs)/configTab";
import ServerTab from "../../(tabs)/config/serverTab";
import DebugTab from "../../(tabs)/debugTab";
import UserTab from "../../(tabs)/config/userTab";
import UserDataTab from "../../(tabs)/config/userDataTab";

const ConfigStack = createStackNavigator();

const SettingsStack = () => {
  return (
    <ConfigStack.Navigator
      initialRouteName="ConfigIndex"
      screenOptions={{
        ...TransitionPresets.RevealFromBottomAndroid,
        transitionSpec: {
          open: {
            animation: "timing",
            config: {
              duration: 150,
            },
          },
          close: {
            animation: "timing",
            config: {
              duration: 200,
            },
          },
        },
      }}
    >
      <ConfigStack.Screen
        name="ConfigIndex"
        component={configTab}
        options={{
          headerShown: false,
        }}
      />
      <ConfigStack.Screen
        name="User"
        component={UserTab}
        options={{
          headerShown: false,
        }}
      />
      <ConfigStack.Screen
        name="UserData"
        component={UserDataTab}
        options={{
          headerShown: false,
        }}
      />
      <ConfigStack.Screen
        name="Server"
        component={ServerTab}
        options={{
          headerShown: false,
        }}
      />
      <ConfigStack.Screen
        name="Debug"
        component={DebugTab}
        options={{
          headerShown: false,
        }}
      />
    </ConfigStack.Navigator>
  );
};

export default SettingsStack;
