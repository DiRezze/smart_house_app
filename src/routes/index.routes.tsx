import { NavigationContainer, DefaultTheme } from "@react-navigation/native";
import TabRoutes from "./tabs.routes";
import { AuthProvider, useAuth } from "../contexts/authContext";
import { LandingStack } from "./landing.routes";
import { colors } from "../constants/colors";

const AppTheme = {
  ...DefaultTheme,
  colors: {
    ...DefaultTheme.colors,
    background: colors.dark.background,
  },
};

function Routes() {
  const { isAuthenticated } = useAuth();
  return (
    <NavigationContainer theme={AppTheme}>
      {isAuthenticated ? <TabRoutes /> : <LandingStack />}
    </NavigationContainer>
  );
}

export default function AppRoutes() {
  return (
    <AuthProvider>
      <Routes />
    </AuthProvider>
  );
}
