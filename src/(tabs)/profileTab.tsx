import { ScrollView, StyleSheet, Text, View } from "react-native";
import { Feather } from "@expo/vector-icons";
import React from "react";
import BlankCard from "../components/blankCard";
import { colors } from "../constants/colors";
import IconCard from "../components/iconCard";

const ProfileTab = () => {
  return (
    <ScrollView contentContainerStyle={styles.tabContainer}>
      <View style={styles.profile}>
        <View style={styles.userIco}>
          <Feather
            name="user"
            size={48}
            color={colors.dark.softWhite}
          />
        </View>
      </View>
      <IconCard
        title="Página em construção..."
        icon="info"
        color="#73D0F5"
      />
    </ScrollView>
  );
};

export default ProfileTab;

const styles = StyleSheet.create({
  tabContainer: {
    marginTop: 16,
    flex: 1,
    alignItems: "center",
  },
  userIco: {
    marginRight: 6,
    padding: 16,
    borderRadius: 256,
    color: colors.dark.softWhite,
    backgroundColor: colors.dark.secondary,
  },
  profile: {
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    flexDirection: "row",
    marginVertical: 32,
    padding: 16,
    width: "95%",
  },
});
