import { StyleSheet, Text, TouchableOpacity, View } from "react-native";
import React from "react";
import { colors } from "../constants/colors";

interface PrimaryButtonProps {
  textContent: String;
  action: (...args: any[]) => void;
  params?: any[];
}

const PrimaryButton: React.FC<PrimaryButtonProps> = ({
  textContent,
  action,
  params = [],
}) => {
  return (
    <TouchableOpacity
      style={styles.container}
      onPress={() => action(...params)}
    >
      <Text style={styles.text}>{textContent}</Text>
    </TouchableOpacity>
  );
};

export default PrimaryButton;

const styles = StyleSheet.create({
  container: {
    padding: 8,
    paddingHorizontal: 16,
    borderRadius: 42,
    backgroundColor: colors.dark.primary,
    width: "90%",
    margin: 8,
    height: 42,
    display: "flex",
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center",
    minWidth: "40%",
  },
  text: {
    textAlign: "center",
    fontWeight: "bold",
    fontSize: 20,
    color: colors.dark.background,
  },
});
