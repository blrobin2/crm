require 'faker'

# rubocop:disable Metrics/BlockLength
namespace :seeder do
  task territories: :environment do
    territories = {
      americas: {
        canada: {
          alberta: {},
          british_columbia: {},
          manitoba: {},
          new_brunswick: {},
          newfoundland_and_labrador: {},
          nova_scotia: {},
          ontario: {},
          prince_edward_island: {},
          quebec: {},
          saskatchewan: {}
        },
        latin_america_and_carribian: {
          argentina: {},
          bahamas_the: {},
          barbados: {},
          belize: {},
          bolivia: {},
          brazil: {},
          colombia: {},
          costa_rica: {},
          dominican_republic: {},
          el_salvador: {},
          ecuador: {},
          grenada: {},
          guatemala: {},
          guyana: {},
          haiti: {},
          honduras: {},
          jamaica: {},
          mexico: {},
          nicaragua: {},
          panama: {},
          paraguay: {},
          peru: {},
          puerto_rico: {},
          st_kits_and_nevis: {},
          st_lucia: {},
          st_vincent_and_the_grenadines: {},
          suriname: {},
          trinidad_and_tobago: {},
          uruguay: {},
          venezuela_rb: {}
        },
        usa: {
          midwest: {
            illinois: {},
            indiana: {},
            iowa: {},
            kansas: {},
            michigan: {},
            minnesota: {},
            missouri: {},
            nebraska: {},
            north_dakota: {},
            ohio: {},
            south_dakota: {},
            wisconsin: {}
          },
          northeast: {
            connecticut: {},
            delaware: {},
            maryland: {},
            massachusetts: {},
            maine: {},
            new_hampshire: {},
            new_jersey: {},
            new_york: {},
            pennsylvania: {},
            rhode_island: {},
            vermont: {}
          },
          southeast: {
            alabama: {},
            arkansas: {},
            florida: {},
            georgia_us: {},
            kentucky: {},
            louisiana: {},
            mississippi: {},
            north_carolina: {},
            tennessee: {},
            south_carolina: {},
            virginia: {},
            west_virginia: {}
          },
          southwest: {
            arizona: {},
            new_mexico: {},
            ohio: {},
            oklahoma: {},
            texas: {}
          },
          west: {
            alaska: {},
            california: {},
            colorado: {},
            hawaii: {},
            idaho: {},
            montana: {},
            nevada: {},
            oregon: {},
            utah: {},
            washington: {},
            wyoming: {}
          },
          united_states_virgin_islands: {}
        }
      },
      european_union: {
        austria: {},
        belgium: {},
        bulgaria: {},
        croatia: {},
        cyprus: {},
        czech_republic: {},
        denmark: {},
        estonia: {},
        finland: {},
        france: {},
        germany: {},
        greece: {},
        hungary: {},
        ireland: {},
        italy: {},
        latvia: {},
        lithuania: {},
        luxembourg: {},
        malta: {},
        netherlands: {},
        poland: {},
        portugal: {},
        romania: {},
        scotland: {},
        slovak_republic: {},
        slovenia: {},
        spain: {},
        sweden: {},
        united_kingdom: {}
      },
      europe_and_central_asia: {
        albania: {},
        armenia: {},
        azerbaijan: {},
        belarus: {},
        bosnia_and_herzegovina: {},
        coratia: {},
        georgia: {},
        kazakhstan: {},
        kosovo: {},
        kyrgyz_republic: {},
        moldova: {},
        montenegro: {},
        north_macedonia: {},
        russian_federation: {},
        san_marino: {},
        serbia: {},
        tajikistan: {},
        turkey: {},
        ukraine: {},
        uzbekistan: {}
      },
      asia_pacific: {
        australia: {},
        brunei_darussalam: {},
        china: {},
        hong_kong: {},
        indonesia: {},
        japan: {},
        malaysia: {},
        new_zealand: {},
        papau_new_guinea: {},
        philippines: {},
        singapore: {},
        taiwan: {},
        thailand: {},
        vietnam: {}
      },
      south_asia: {
        afghanistan: {},
        bangladesh: {},
        bhutan: {},
        india: {},
        maldives: {},
        nepal: {},
        pakistan: {},
        sri_lanka: {}
      },
      middle_east_north_africa: {
        algeria: {},
        bahrain: {},
        djibouti: {},
        egypt_arab_rep: {},
        iran_islamic_rep: {},
        iraq: {},
        jordan: {},
        lebanon: {},
        libya: {},
        kuwait: {},
        malta: {},
        morocco: {},
        oman: {},
        qatar: {},
        saudi_ariabia: {},
        syrian_arab_republic: {},
        tunsinia: {},
        united_arab_emirates: {},
        west_bank_and_gaza: {},
        yemen_rep: {}
      },
      sub_saharan_africa: {
        angola: {},
        benin: {},
        botswana: {},
        burkina_faso: {},
        burundi: {},
        cabo_verde: {},
        cameroon: {},
        centra_african_republic: {},
        chad: {},
        comoros: {},
        congo_dem_rep: {},
        congo_rep: {},
        côte_d_ivoire: {},
        equatorial_guinea: {},
        eritrea: {},
        eswatini: {},
        ethiopia: {},
        gabon: {},
        gambia_the: {},
        ghana: {},
        guinea: {},
        guinea_bissau: {},
        kenya: {},
        lesotho: {},
        liberia: {},
        madagascar: {},
        malawi: {},
        mali: {},
        mauritania: {},
        mauritius: {},
        mozambique: {},
        namibia: {},
        niger: {},
        nigeria: {},
        rwanda: {},
        senegal: {},
        somalia: {},
        sychelles: {},
        sierra_leone: {},
        south_africa: {},
        south_sudan: {},
        sudan: {},
        tanzania: {},
        tomé_and_príncipe: {},
        togo: {},
        uganda: {},
        zambia: {},
        zimbabwe: {}
      }
    }

    create_child_territories = lamda do |territory, children|
      children.each do |name, members|
        t = Territory.find_or_initialize_by(name: name)
        t.parent = territory
        t.save!
        create_child_territories.call(t, members)
      end
    end

    territories.each do |name, members|
      t = Territory.find_or_create_by!(name: name)
      create_child_territories.call(t, members)
    end
  end

  task sales_and_advisors: :environment do
    Territory.roots.each do |root|
      root.children.each do |child|
        sales = User.create!(
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.unique.email,
          password: 'password',
          role: :sales
        )
        advisor = User.create!(
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.unique.email,
          password: 'password',
          role: :advisor
        )
        child.sales_id = sales.reload.id
        child.advisor_id = advisor.reload.id
        child.save!
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
