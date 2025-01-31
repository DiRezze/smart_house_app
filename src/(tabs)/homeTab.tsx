import { StyleSheet, Text, View } from "react-native";
import { getGreeting } from "../scripts/greetings";
import { Feather } from "@expo/vector-icons";
import React from "react";
import { colors } from "../constants/colors";
import TabScroll from "../components/tabScroll";
import BlankCard from "../components/blankCard";
import UserHeader from "../components/userHeader";
import IconCard from "../components/iconCard";
import AppTitle from "../components/appTitle";

const Home = () => {
  return (
    <TabScroll>
      <UserHeader />
      <View style={styles.titleContainer}>
        <AppTitle colorVersion={true} />
      </View>
      <IconCard
        title="Você está logado!"
        icon="info"
        color="#73D0F5"
      />
      <IconCard
        title="Leia sobre o app"
        icon="external-link"
        color="#F57375"
      />
    </TabScroll>
  );
};

export default Home;

const styles = StyleSheet.create({
  clock: {
    fontSize: 64,
    color: colors.dark.softWhite,
    fontWeight: 800,
    marginVertical: 24,
  },
  titleContainer: {
    marginVertical: 32,
  },
});
