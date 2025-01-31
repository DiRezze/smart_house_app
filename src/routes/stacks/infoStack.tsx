import {
  createStackNavigator,
  TransitionPresets,
} from "@react-navigation/stack";
import InfoTab from "../../(tabs)/infoTab";
import VersionInfoTab from "../../(tabs)/info/versionInfoTab";
import LegalTab from "../../(tabs)/info/legalTab";
import ReportTab from "../../(tabs)/info/reportTab";

const Stack = createStackNavigator();

const InfoStack = () => {
  return (
    <Stack.Navigator
      initialRouteName="About"
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
        name="About"
        component={InfoTab}
        options={{
          headerShown: false,
        }}
      />
      <Stack.Screen
        name="Report"
        component={ReportTab}
        options={{
          headerShown: false,
        }}
      />
      <Stack.Screen
        name="Version"
        component={VersionInfoTab}
        options={{
          headerShown: false,
        }}
      />
      <Stack.Screen
        name="Legal"
        component={LegalTab}
        options={{
          headerShown: false,
        }}
      />
    </Stack.Navigator>
  );
};

export default InfoStack;
