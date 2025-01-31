import { SafeAreaProvider, SafeAreaView } from "react-native-safe-area-context";
import AppRoutes from "./src/routes/index.routes";
import { StyleSheet, View } from "react-native";
import { colors } from "./src/constants/colors";
import { StatusBar } from "expo-status-bar";

export default function App() {
  return (
    <SafeAreaProvider
      style={{ flex: 1, backgroundColor: colors.dark.background }}
    >
      <AppRoutes />
      <StatusBar
        style="light"
        backgroundColor="transparent"
      />
    </SafeAreaProvider>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    backgroundColor: colors.dark.background,
    flex: 1,
  },
});
