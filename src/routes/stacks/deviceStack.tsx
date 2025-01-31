import React from "react";
import {
  createStackNavigator,
  TransitionPresets,
} from "@react-navigation/stack";
import DeviceTab from "../../(tabs)/devices/devicesTab";
import AddDeviceTab from "../../(tabs)/devices/addDeviceTab";

const ConfigStack = createStackNavigator();

const DeviceStack = () => {
  return (
    <ConfigStack.Navigator
      initialRouteName="DeviceList"
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
        name="DeviceList"
        component={DeviceTab}
        options={{
          headerShown: false,
        }}
      />
      <ConfigStack.Screen
        name="AddDevice"
        component={AddDeviceTab}
        options={{
          headerShown: false,
        }}
      />
    </ConfigStack.Navigator>
  );
};

export default DeviceStack;
