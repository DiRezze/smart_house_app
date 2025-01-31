import { StyleSheet, Text, View } from "react-native";
import TabScroll from "../../components/tabScroll";
import { colors } from "../../constants/colors";
import { useNavigation } from "@react-navigation/native";
import BlankCard from "../../components/blankCard";
import { info } from "../../constants/appInfo";
import BackNavigateButton from "../../components/backNavigate";

const VersionInfoTab: React.FC = () => {
  return (
    <TabScroll>
      <View style={styles.mainContainer}>
        <BackNavigateButton />
        <Text style={styles.title}>Informações de versão</Text>
        <BlankCard>
          <View style={styles.container}>
            <Text style={styles.text}>
              <Text style={{ fontWeight: "bold" }}>Versão: </Text>
              {info.versionDetails.version}
            </Text>
            <Text style={styles.text}>
              <Text style={{ fontWeight: "bold" }}>Data: </Text>
              Janeiro/2025
            </Text>
          </View>
        </BlankCard>
        <BlankCard>
          <View style={styles.container}>
            <Text style={styles.text}>
              <Text style={{ fontWeight: "bold" }}>Novidades: </Text>
              {info.versionDetails.updates}.
            </Text>
          </View>
        </BlankCard>
      </View>
    </TabScroll>
  );
};

export default VersionInfoTab;

const styles = StyleSheet.create({
  title: {
    color: colors.dark.softWhite,
    fontWeight: 700,
    fontSize: 32,
    textAlign: "center",
    marginTop: 48,
    marginBottom: 32,
  },
  text: {
    color: colors.dark.softWhite,
    fontSize: 24,
    textAlign: "left",
  },
  container: {
    width: "100%",
    padding: 8,
    gap: 12,
  },
  mainContainer: {
    flex: 1,
    width: "100%",
    alignItems: "center",
  },
});
