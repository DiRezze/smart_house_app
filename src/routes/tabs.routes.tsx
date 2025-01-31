import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { Feather } from "@expo/vector-icons";
import * as React from "react";
import DebugTab from "../(tabs)/debugTab";
import Home from "../(tabs)/homeTab";
import ProfileTab from "../(tabs)/profileTab";
import ConfigTab from "../(tabs)/configTab";
import InfoTab from "../(tabs)/infoTab";
import { colors } from "../constants/colors";
import InfoStack from "./stacks/infoStack";
import SettingsStack from "./stacks/settingsStack";
import DeviceStack from "./stacks/deviceStack";

const Tab = createBottomTabNavigator();

export default function TabRoutes() {
  return (
    <Tab.Navigator
      screenOptions={{
        tabBarInactiveTintColor: "gray",
        tabBarActiveTintColor: colors.dark.secondary,
        tabBarStyle: {
          backgroundColor: colors.dark.secondaryBackground,
          padding: 4,
          borderTopWidth: 2,
          borderBlockColor: "#333",
          height: 56,
        },
      }}
      initialRouteName="Home"
    >
      <Tab.Screen
        name="Info"
        component={InfoStack}
        options={{
          tabBarIcon: ({ color, size }) => (
            <Feather
              name="info"
              color={color}
              size={size}
            />
          ),
          tabBarLabel: "Informação",
          headerShown: false,
        }}
      />
      <Tab.Screen
        name="Perfil"
        component={ProfileTab}
        options={{
          tabBarIcon: ({ color, size }) => (
            <Feather
              name="user"
              color={color}
              size={size}
            />
          ),
          tabBarLabel: "Perfil",
          headerShown: false,
        }}
      />
      <Tab.Screen
        name="Home"
        component={Home}
        options={{
          tabBarIcon: ({ color, size }) => (
            <Feather
              name="home"
              color={color}
              size={size}
            />
          ),
          tabBarLabel: "Início",
          headerShown: false,
        }}
      />
      <Tab.Screen
        name="Dispositivos"
        component={DeviceStack}
        options={{
          tabBarIcon: ({ color, size }) => (
            <Feather
              name="layers"
              color={color}
              size={size}
            />
          ),
          tabBarLabel: "Dispositivos",
          headerShown: false,
        }}
      />
      <Tab.Screen
        name="Config"
        component={SettingsStack}
        options={{
          tabBarIcon: ({ color, size }) => (
            <Feather
              name="settings"
              color={color}
              size={size}
            />
          ),
          tabBarLabel: "Config.",
          headerShown: false,
        }}
      />
    </Tab.Navigator>
  );
}
