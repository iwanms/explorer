<script setup lang="ts">
import { onMounted, ref } from 'vue'
import FolderPanel from './components/LeftPanel.vue'
import FilePanel from './components/RightPanel.vue'
import { fetchFolders, fetchChildren, fetchContents, type FolderUI, type File } from './services/folderApi'

const folders = ref<FolderUI[]>([])
const selectedFolder = ref<FolderUI | null>(null)
const contents = ref<File[]>([])
const selectedFile = ref<File | null>(null)
const error = ref('')

// Load root folders
onMounted(async () => {
  try {
    const data = await fetchFolders()
    console.log("Folders from API:", data)
    folders.value = data.map(f => ({
      ...f,
      isOpen: false,
      children: [],
      isLoading: false
    }))
  } catch (e) {
    error.value = 'Gagal load folders'
  }
})

// Handle folder click
const onFolderClick = async (folder: FolderUI) => {
  if (!folder.parent_id) {
    // Root folder
    folder.isOpen = !folder.isOpen
    selectedFolder.value = null
    contents.value = []

    if (folder.isOpen && !folder.children?.length) {
      folder.isLoading = true
      try {
        const childData = await fetchChildren(folder.id)
        folder.children = childData.map((f: any) => ({
          ...f,
          isOpen: false,
          children: []
        }))
      } finally {
        folder.isLoading = false
      }
    }
  }

  // fetch content
  selectedFolder.value = folder
  selectedFile.value = null
  try {
    contents.value = await fetchContents(folder.id)
  } catch {
    contents.value = []
  }
}

// Handle file click
const onFileClick = (file: File) => {
  selectedFile.value = file
}
</script>

<template>
  <div class="container-fluid">
    <div class="row vh-100">
      <div class="col-3 border-end p-3 bg-light overflow-auto">
        <h5 class="mb-3">Explorer</h5>
        <FolderPanel :folders="folders" :selectedFolder="selectedFolder" @folder-click="onFolderClick" />
      </div>

      <div class="col-9 p-4">
        <h5>Detail Konten</h5>
        <hr>
        <FilePanel :contents="contents" :selectedFile="selectedFile" :selectedFolder="selectedFolder"
          @file-click="onFileClick" />
      </div>
    </div>
  </div>
</template>
