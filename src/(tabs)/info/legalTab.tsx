import { StyleSheet, Text, View } from "react-native";
import TabScroll from "../../components/tabScroll";
import { colors } from "../../constants/colors";
import BlankCard from "../../components/blankCard";
import BackNavigateButton from "../../components/backNavigate";

const LegalTab: React.FC = () => {
  return (
    <TabScroll>
      <View style={styles.mainContainer}>
        <BackNavigateButton />
        <Text style={styles.title}>Termos Legais</Text>
        <BlankCard>
          <View style={styles.container}>
            <Text style={styles.text}>
              Todas as imagens utilizadas como plano de fundo neste app foram
              desenvolvidas por FreePik.com
            </Text>
          </View>
        </BlankCard>
      </View>
    </TabScroll>
  );
};

export default LegalTab;

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
    textAlign: "justify",
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
