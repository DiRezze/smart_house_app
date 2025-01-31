import { StyleSheet, Text, TouchableOpacity } from "react-native";
import { Feather } from "@expo/vector-icons";
import React from "react";
import { useNavigation } from "@react-navigation/native";

const BackNavigateButton = () => {
  const navigation = useNavigation();
  return (
    <TouchableOpacity
      style={styles.buttonContainer}
      onPress={() => navigation.goBack()}
    >
      <Feather
        style={styles.btnIcon}
        name="chevron-left"
        size={32}
      />
      <Text style={styles.btnText}>Voltar</Text>
    </TouchableOpacity>
  );
};

export default BackNavigateButton;

const styles = StyleSheet.create({
  buttonContainer: {
    marginTop: 16,
    display: "flex",
    flexDirection: "row",
    width: "50%",
    alignItems: "center",
    padding: 6,
    position: "absolute",
    top: 0,
    left: 0,
    zIndex: 999,
  },
  btnText: {
    color: "#FEFEFE",
    fontWeight: "semibold",
  },
  btnIcon: {
    color: "#FEFEFE",
  },
});
