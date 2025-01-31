import { Text, StyleSheet } from "react-native";
import TabScroll from "../../components/tabScroll";
import { colors } from "../../constants/colors";
import BackNavigateButton from "../../components/backNavigate";
import NavPath from "../../components/navPath";
import IconCard from "../../components/iconCard";

const UserDataTab = () => {
  return (
    <TabScroll>
      <BackNavigateButton />
      <Text style={styles.title}>Seus dados</Text>
      <NavPath text="Configurações/Usuário/Seus dados" />
      <IconCard
        title="Página em construção..."
        icon="info"
        color="#73D0F5"
      />
    </TabScroll>
  );
};

export default UserDataTab;

const styles = StyleSheet.create({
  title: {
    fontSize: 48,
    marginVertical: 32,
    textAlign: "center",
    fontWeight: 700,
    color: colors.dark.softWhite,
  },
});
