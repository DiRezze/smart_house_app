import { LinearGradient } from "expo-linear-gradient";
import { ReactNode } from "react";
import { ImageBackground, StyleSheet } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import BackNavigateButton from "../components/backNavigate";
import { StatusBar } from "expo-status-bar";
import LandingModal from "../components/landingModal";

interface AuthLayoutProps {
  children: ReactNode;
  backButton: boolean;
}

const AuthLayout: React.FC<AuthLayoutProps> = ({ children, backButton }) => {
  return (
    <SafeAreaView style={styles.full}>
      <ImageBackground
        source={require("../../assets/landing.png")}
        style={styles.full}
      >
        <LinearGradient
          style={styles.full}
          colors={["#060606", "#0606060c"]}
          start={{ x: 0, y: 1 }}
          end={{ x: 0, y: 0 }}
        >
          {backButton ? <BackNavigateButton /> : null}
        </LinearGradient>
        <LandingModal>{children}</LandingModal>
      </ImageBackground>
    </SafeAreaView>
  );
};

export default AuthLayout;

const styles = StyleSheet.create({
  full: {
    flex: 1,
  },
});
