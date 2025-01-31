import {
  createStackNavigator,
  TransitionPresets,
} from "@react-navigation/stack";
import LoginTab from "../(tabs)/loginTab";
import LandingTab from "../(tabs)/landingTab";
import SigninTab from "../(tabs)/signinTab";

const Stack = createStackNavigator<{
  landing: undefined;
  login: undefined;
  signin: undefined;
}>();

export const LandingStack = () => {
  return (
    <Stack.Navigator
      screenOptions={{
        ...TransitionPresets.SlideFromRightIOS,
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
        gestureDirection: "horizontal",
      }}
    >
      <Stack.Screen
        name="landing"
        component={LandingTab}
        options={{ headerShown: false }}
      />
      <Stack.Screen
        name="login"
        component={LoginTab}
        options={{ headerShown: false }}
      />
      <Stack.Screen
        name="signin"
        component={SigninTab}
        options={{ headerShown: false }}
      />
    </Stack.Navigator>
  );
};
