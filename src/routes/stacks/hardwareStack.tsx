import { createStackNavigator, TransitionPresets } from "@react-navigation/stack";
import Hardware from "../../(tabs)/hardwareTab";
import NewNode from "../../(tabs)/newModule";
import { RootStackParamList } from "../../types/nodeNav";

const Stack = createStackNavigator<RootStackParamList>();

const HardwareStack = () => {
  return (
    <Stack.Navigator
      initialRouteName="Hardware"
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
      <Stack.Screen 
        name="Hardware" 
        component={Hardware} 
        options={{
          headerShown: false,
        }}
      />
      <Stack.Screen 
        name="AddModule" 
        component={NewNode} 
        options={{
          headerShown: false,
        }}
      />
    </Stack.Navigator>
  );
};

export default HardwareStack;
