import { StackNavigationProp } from "@react-navigation/stack";

export type RootStackParamList = {
  Home: undefined;
  login: undefined;
  signin: undefined;
};

export type LandingTabNavigationProp = StackNavigationProp<
  RootStackParamList,
  "Home"
>;
