import React from "react";
import { useNavigation } from "@react-navigation/native";
import { LandingTabNavigationProp } from "../../types/navigation";
import { StyleSheet, Text } from "react-native";
import LandingButton from "../../components/LandingButton";
import { colors } from "../../constants/colors";
import AuthLayout from "../../layouts/authLayout";
import AppTitle from "../../components/appTitle";

const LandingTab = () => {
  const navigation = useNavigation<LandingTabNavigationProp>();
  return (
    <AuthLayout backButton={false}>
      <AppTitle colorVersion={false} />
      <LandingButton
        text={"Acessar"}
        onClick={() => navigation.navigate("login")}
        primary={true}
      />
      <LandingButton
        text={"Cadastrar"}
        onClick={() => navigation.navigate("signin")}
        primary={false}
      />
      <Text style={styles.freepik}>Background designed by Freepik</Text>
    </AuthLayout>
  );
};

export default LandingTab;

const styles = StyleSheet.create({
  freepik: {
    color: colors.dark.softGray,
    textAlign: "center",
  },
});
