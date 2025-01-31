import {
  StyleSheet,
  Text,
  TouchableOpacity,
  TouchableWithoutFeedback,
  View,
} from "react-native";
import React from "react";
import TabScroll from "../components/tabScroll";
import { colors } from "../constants/colors";
import SearchBar from "../components/searchBar";
import IconCard from "../components/iconCard";
import { useNavigation } from "@react-navigation/native";

const ConfigTab = () => {
  const navigation = useNavigation();
  return (
    <TabScroll>
      <Text style={styles.title}>Configurações</Text>
      <SearchBar />
      <View style={styles.settingsList}>
        <IconCard
          icon={"user"}
          title="Usuário"
          color={colors.pastel.pink}
          onClick={() => navigation.navigate("User")}
        />
        <IconCard
          icon={"server"}
          title="Servidor"
          color={colors.pastel.blue}
          onClick={() => navigation.navigate("Server")}
        />
        <IconCard
          icon={"terminal"}
          title="Depuração"
          color={colors.pastel.green}
          onClick={() => navigation.navigate("Debug")}
        />
      </View>
    </TabScroll>
  );
};

export default ConfigTab;

const styles = StyleSheet.create({
  title: {
    color: colors.dark.softWhite,
    fontWeight: 700,
    fontSize: 48,
    textAlign: "center",
    marginVertical: 16,
  },
  settingsList: {
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    width: "100%",
  },
});
