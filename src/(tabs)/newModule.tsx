import { StyleSheet, Text, View } from "react-native";
import React from "react";
import TabScroll from "../components/tabScroll";
import BackNavigateButton from "../components/backNavigate";

const NewNode = () => {
  return (
    <TabScroll>
      <BackNavigateButton />
      <Text>Criando novo módulo</Text>
    </TabScroll>
  );
};

export default NewNode;

const styles = StyleSheet.create({});
