import { StyleSheet, Text, TouchableOpacity, View } from "react-native";
import React from "react";
import { doSignOut } from "../firebase/auth";
import { colors } from "../constants/colors";
import BlankCard from "../components/blankCard";
import TabScroll from "../components/tabScroll";
import UserHeader from "../components/userHeader";
import IconCard from "../components/iconCard";
import BackNavigateButton from "../components/backNavigate";
import NavPath from "../components/navPath";

const DebugTab = () => {
  return (
    <TabScroll>
      <BackNavigateButton />
      <Text style={styles.tabTitle}>Depuração</Text>
      <NavPath text="Configurações/Depuração" />
      <IconCard
        title="Página em construção..."
        icon="info"
        color="#73D0F5"
      />
    </TabScroll>
  );
};

export default DebugTab;

const styles = StyleSheet.create({
  cardTitle: {
    fontSize: 20,
    marginVertical: 16,
    color: colors.dark.softWhite,
    textAlign: "center",
    margin: 4,
    fontWeight: "700",
    marginBottom: 12,
  },
  logout: {
    padding: 12,
    borderRadius: 4,
    minWidth: 72,
    backgroundColor: "grey",
  },
  btnText: {
    color: "white",
    textAlign: "center",
  },
  sectionCard: {
    display: "flex",
    alignItems: "center",
    flexDirection: "column",
    justifyContent: "center",
    width: "100%",
  },
  tabTitle: {
    fontSize: 48,
    fontWeight: "600",
    marginVertical: 32,
    color: colors.dark.softWhite,
  },
});
