import { Text, StyleSheet } from "react-native";
import TabScroll from "../../components/tabScroll";
import { colors } from "../../constants/colors";
import PrimaryButton from "../../components/primaryButton";
import { useNavigation } from "@react-navigation/native";
import UserHeader from "../../components/userHeader";
import DeviceList from "../../components/deviceList";
import SearchBar from "../../components/searchBar";

const DeviceTab = () => {
  const navigation = useNavigation();
  return (
    <TabScroll>
      <UserHeader />
      <Text style={styles.title}>Dispositivos</Text>
      <SearchBar />
      <PrimaryButton
        action={() => navigation.navigate("AddDevice")}
        textContent={"Adicionar"}
      />
      <DeviceList />
    </TabScroll>
  );
};

export default DeviceTab;

const styles = StyleSheet.create({
  title: {
    fontSize: 48,
    margin: 12,
    textAlign: "center",
    fontWeight: 700,
    color: colors.dark.softWhite,
  },
  deviceList: {
    width: "100%",
    marginVertical: 8,
    alignItems: "center",
  },
});
