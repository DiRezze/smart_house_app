import React from "react";
import { useNavigation } from "@react-navigation/native";
import { LandingTabNavigationProp } from "../../types/navigation";
import { LinearGradient } from "expo-linear-gradient";
import { ImageBackground, StyleSheet, Text, View } from "react-native";
import LandingButton from "../../components/LandingButton";
import { colors } from "../../constants/colors";

const LandingTab = () => {
  const navigation = useNavigation<LandingTabNavigationProp>();

  return (
    <ImageBackground
      source={require("../../../assets/landing.png")}
      style={styles.imgBg}
    >
      <LinearGradient
        style={styles.imgBg}
        colors={["#060606", "#0606060c"]}
        start={{ x: 0, y: 1 }}
        end={{ x: 0, y: 0 }}
      ></LinearGradient>
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
    </ImageBackground>
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
