import { StyleSheet, Text, View } from 'react-native'
import React, { useState } from 'react'
import TabScroll from '../components/tabScroll'
import PrimaryButton from '../components/primaryButton'
import { useNavigation } from '@react-navigation/native'
import { BottomTabNavigationProp } from '@react-navigation/bottom-tabs'
import { HardwareTabNavigationProp, RootStackParamList } from '../types/nodeNav'

type HardwareScreenNavigationProp = BottomTabNavigationProp<RootStackParamList, 'Hardware'>;

const Hardware = () => {
  const navigation = useNavigation<HardwareTabNavigationProp>();

  const [moduleList, setModuleList] = useState([]); 

  return (
    <TabScroll>
      <Text style={styles.title}>Hardware</Text>
      <PrimaryButton
        textContent="Adicionar novo módulo"
        action={() => navigation.navigate('AddModule')}
      />
      <View style={styles.nodeList}>
        { moduleList.length == 0 ?
          <Text style={styles.missingNodes}>Você ainda não tem módulos cadastrados</Text> : <Text>Lista</Text>
        }
      </View>
    </TabScroll>
  )
}

export default Hardware

const styles = StyleSheet.create({
  title: {
    fontSize: 32,
    fontWeight: "700",
  },
  missingNodes: {
    alignSelf: "center",
    justifyContent: "center",
  },
  nodeList: {
    flex: 1,
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center",
  },
});