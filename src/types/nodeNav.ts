import { StackNavigationProp } from "@react-navigation/stack";

export type RootStackParamList = {
    Hardware: undefined;
    AddModule: undefined;
};

export type HardwareTabNavigationProp = StackNavigationProp<RootStackParamList, 'Hardware'>;