import { ScrollView, StyleSheet } from "react-native";
import React, { ReactNode } from "react";
import { SafeAreaView } from "react-native-safe-area-context";

interface TabScroll {
  children: ReactNode;
}

const TabScroll: React.FC<TabScroll> = ({ children }) => {
  return (
    <SafeAreaView>
      <ScrollView
        contentContainerStyle={styles.tabContainer}
        showsVerticalScrollIndicator={false}
      >
        {children}
      </ScrollView>
    </SafeAreaView>
  );
};

export default TabScroll;

const styles = StyleSheet.create({
  tabContainer: {
    flexGrow: 1,
    alignItems: "center",
    flexDirection: "column",
  },
});
