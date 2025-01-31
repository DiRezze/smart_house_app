import React from "react";
import { useNavigation } from "@react-navigation/native";
import { LandingTabNavigationProp } from "../../types/navigation";
import { StyleSheet, Text, View } from "react-native";
import LandingButton from "../../components/LandingButton";
import { colors } from "../../constants/colors";
import AuthLayout from "../../layouts/authLayout";

const LandingTab = () => {
  const navigation = useNavigation<LandingTabNavigationProp>();

  return (
    <AuthLayout backButton={false}>
      <View style={styles.modal}>
        <Text style={styles.appName}>Projeto FETEPS</Text>
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
      </View>
    </AuthLayout>
  );
};

export default LandingTab;

const styles = StyleSheet.create({
  imgBg: {
    flex: 1,
  },
  modal: {
    backgroundColor: "#060606",
    height: 280,
  },
  appName: {
    color: "#FEFEFE",
    fontSize: 48,
    fontWeight: 600,
    textAlign: "center",
  },
  freepik: {
    color: colors.dark.softGray,
    textAlign: "center",
  },
});
